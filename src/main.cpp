#include <opencv2/opencv.hpp>
#include <iostream>
#include <vector>
#include <cmath>
#include <vector>

/**
 * @brief Preprocesses input image to detect and enhance edges.  
 * 
 * DEBUG: Saves each intermediate step in frames vector.
 * 1. Original image
 * 2. Converts image to grayscale.
 * 3. Gaussian blur to reduce noise.
 * 4. Canny edge detection algorithm.
 * 5. Dilation to thicken edges.
 * 6. Erosion to refine edges.
 * 
 * @param img The input image (cv::Mat) in BGR format.
 * @return std::vector<cv::Mat> The 6 frames used to preprocess the image.
 */
std::vector<cv::Mat> preprocess(const cv::Mat& img) {
    std::vector<cv::Mat> frames;
    cv::Mat grayscaled, blurred, edge_detected, dilated, eroded;
    cv::Mat kernel = cv::getStructuringElement(cv::MORPH_RECT, cv::Size(3, 3));
    
    frames.push_back(img.clone());

    cv::cvtColor(img, grayscaled, cv::COLOR_BGR2GRAY);
    frames.push_back(grayscaled.clone());

    cv::GaussianBlur(grayscaled, blurred, cv::Size(5, 5), 1);
    frames.push_back(blurred.clone());

    cv::Canny(blurred, edge_detected, 50, 150);
    frames.push_back(edge_detected.clone());

    cv::dilate(edge_detected, dilated, kernel, cv::Point(-1, -1), 2);
    frames.push_back(dilated.clone());

    cv::erode(dilated, eroded, kernel, cv::Point(-1, -1), 1);
    frames.push_back(eroded.clone());

    return frames;
}

/**
 * @brief Finds a tip point from a polygon approximation and its convex hull.
 * 
 * @param approx The polygon approximation as a vector<cv::Point>.
 * @param hull A vector<int> of convex hull indices corresponding to points in `approx`.
 * @return cv::Point The tip if found, or `cv::Point(-1, -1)` if no valid tip exists.
 */
cv::Point findTip(const std::vector<cv::Point> &approx, const std::vector<int> &hull) {
    std::vector<int> indices;
    for (int i = 0; i < static_cast<int>(approx.size()); i++) {
        if (std::find(hull.begin(), hull.end(), i) == hull.end()) {
            indices.push_back(i);
        }
    }

    if (indices.size() != 2) return cv::Point(-1, -1);

    for (int i = 0; i < 2; i++) {
        int j = indices[i] + 2;
        if (j >= static_cast<int>(approx.size())) {
            j -= static_cast<int>(approx.size());
        }
        if (j < 0 || j >= static_cast<int>(approx.size())) {
            continue;
        }

        int next_index = (indices[(i + 1) % 2] - 2 + static_cast<int>(approx.size()))
                          % static_cast<int>(approx.size());
        if (approx[j] == approx[next_index]) {
            return approx[j];
        }
    }
    return cv::Point(-1, -1);
}

/**
 * @brief Determines the direction of a point relative to the center of a bounding box.
 * 
 * @param tip The cv::Point used to calculate the direction for.
 * @param boundingBox The bounding box as a cv::Rect, used to calculate the center.
 * 
 * @return A std::string representing the direction of the point as "Left", "Right", "Up", or "Down".
 */
std::string getArrowDirection(const cv::Point &tip, const cv::Rect &bounding_box) {
    cv::Point center = (bounding_box.tl() + bounding_box.br()) * 0.5;
    int dx = tip.x - center.x;
    int dy = tip.y - center.y;

    double angle = std::atan2(dy, dx) * 180.0 / CV_PI;
    if (angle >= -45 && angle <= 45)  return "Right";
    if (angle > 45 && angle < 135)   return "Down";
    if (angle <= -45 && angle > -135) return "Up";
    return "Left";
}

/** 
 * @brief Converts all 1-channel frames to BGR. Retains frames already with BGR channels.
 * 
 * @param frames A std::vector<cv::Mat> of the frames to convert.
 * 
 * @return A std::vector<cv::Mat> of the BGR frames. 
*/

std::vector<cv::Mat> framesToBGR(const std::vector<cv::Mat>& frames) {
    std::vector<cv::Mat> converted_frames;
    for (const cv::Mat& frame : frames) {
        cv::Mat frame_matched;
        if (frame.channels() == 1) {
            cv::cvtColor(frame, frame_matched, cv::COLOR_GRAY2BGR);
        } else {
            frame_matched = frame.clone();
        }

        converted_frames.push_back(frame_matched);
    }
    return converted_frames;
}

/**
 * @brief Displays multiple frames into a grid format. 
 * 
 * @param window_name The name of the window to display the frames grid..
 * @param frames A std::vector<cv::Mat> storing the frames to display.
 * @param rows A size_t with the number of of row in the grid.
 * @param columns A size_t with the number of columsn in the grid.
 */
void displayFrames(const std::string& window_name, const std::vector<cv::Mat>& frames, size_t rows, size_t columns) {
    std::vector<cv::Mat> grid_rows;
    for (size_t i = 0; i < rows; ++i) {
        std::vector<cv::Mat> row_frames;
        
        for (size_t j = 0; j < columns; ++j) {
            size_t idx = i * columns + j;
            if (idx < frames.size()) {
                row_frames.push_back(frames[idx]);
            } else {
                row_frames.push_back(cv::Mat::zeros(frames[0].size(), frames[0].type()));
            }
        }
        
        cv::Mat row_combined;
        cv::hconcat(row_frames, row_combined);
        grid_rows.push_back(row_combined);
    }

    // combine rows and display
    cv::Mat grid_combined;
    cv::vconcat(grid_rows, grid_combined);
    cv::imshow(window_name, grid_combined);
}

int main() {
    std::string window_name = "Preprocess Debug";

    cv::VideoCapture cap(0);    
    if (!cap.isOpened()) {
        std::cerr << "Error: Could not open the webcam!" << std::endl;
        return -1;
    }
    cv::namedWindow(window_name, cv::WINDOW_NORMAL | cv::WINDOW_GUI_NORMAL);
    cv::resizeWindow(window_name, 1280, 720);

    while (true) {
        if (cv::getWindowProperty(window_name, cv::WND_PROP_VISIBLE) < 1) break;
        
        cv::Mat capture_frame;
        cap >> capture_frame;
        if (capture_frame.empty()) break;

        std::vector<cv::Mat> frames_preprocessed = preprocess(capture_frame);
        std::vector<cv::Mat> frames_display = framesToBGR(frames_preprocessed);

        std::vector<std::vector<cv::Point>> contours;
        std::vector<cv::Vec4i> hierarchy;

        cv::findContours(frames_preprocessed.back(), contours, hierarchy, cv::RETR_EXTERNAL, cv::CHAIN_APPROX_NONE);

        // find and display arrows from contours
        for (const auto &cnt : contours) {
            double peri = cv::arcLength(cnt, true);
            std::vector<cv::Point> approx;
            cv::approxPolyDP(cnt, approx, 0.025 * peri, true);

            std::vector<int> hull_indices;
            cv::convexHull(approx, hull_indices, false);

            if (hull_indices.size() >= 4 && hull_indices.size() <= 6) {
                cv::Point arrow_tip = findTip(approx, hull_indices);
                if (arrow_tip != cv::Point(-1, -1)) {
                    cv::Rect bounding_box = cv::boundingRect(cnt);
                    std::string direction = getArrowDirection(arrow_tip, bounding_box);

                    for (size_t i = 0; i < frames_display.size(); i++) {
                        cv::drawContours(frames_display[i], std::vector<std::vector<cv::Point>>{cnt}, -1, cv::Scalar(0, 255, 0), 2);
                        cv::circle(frames_display[i], arrow_tip, 5, cv::Scalar(0, 0, 255), cv::FILLED);
                        cv::putText(frames_display[i], "Dir: " + direction, arrow_tip + cv::Point(30, 30), cv::FONT_HERSHEY_PLAIN, 2, cv::Scalar(255, 0, 0), 2);
                    }
                }
            }
        }

        // add labels to frames
        std::string labels[] = {"Original", "Grayscale", "Gaussian Blur", "Canny Edge Detection", "Dilation", "Erosion"};
        for (size_t i = 0; i < frames_display.size(); i++) {
            cv::Size text_size = cv::getTextSize(labels[i], cv::FONT_HERSHEY_COMPLEX, 1.1, 1, 0);
            size_t x = (frames_display[i].cols - text_size.width) / 2;
            size_t y = (frames_display[i].rows - text_size.height) / 8;
            cv::putText(frames_display[i], labels[i], cv::Point(x, y), cv::FONT_HERSHEY_COMPLEX, 1.1, cv::Scalar(0, 0, 0), 12);
            cv::putText(frames_display[i], labels[i], cv::Point(x, y), cv::FONT_HERSHEY_COMPLEX, 1.1, cv::Scalar(255, 255, 255), 2);
        }

        displayFrames(window_name, frames_display, 2, 3);
        cv::waitKey(1);
    }

    cap.release();
    cv::destroyAllWindows();
    return 0;
}
