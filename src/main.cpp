#include <opencv2/opencv.hpp>
#include <iostream>
#include <vector>
#include <cmath>

/**
 * @brief Preprocesses input image to detect and enhance edges.
 * 
 * 1. Converts image to grayscale.
 * 2. Gaussian blur to reduce noise.
 * 3. Canny edge detection algorithm.
 * 4. Dilation to thicken edges.
 * 5. Erosion to refine edges.
 * 
 * @param img The input image (cv::Mat) in BGR format.
 * @return cv::Mat The preprocessed image with refined edges.
 */
cv::Mat preprocess(const cv::Mat &img) {
    cv::Mat gray, blurImg, canny, dilateImg, erodeImg;

    cv::cvtColor(img, gray, cv::COLOR_BGR2GRAY);
    cv::GaussianBlur(gray, blurImg, cv::Size(5, 5), 1);
    cv::Canny(blurImg, canny, 50, 150);

    cv::Mat kernel = cv::getStructuringElement(cv::MORPH_RECT, cv::Size(3, 3));
    cv::dilate(canny, dilateImg, kernel, cv::Point(-1, -1), 2);
    cv::erode(dilateImg, erodeImg, kernel, cv::Point(-1, -1), 1);

    return erodeImg;
}

/**
 * @brief Finds a tip point from a polygon approximation and its convex hull.
 * 
 * @param approx The polygon approximation as a vector<cv::Point>.
 * @param hull A vector<int> of convex hull indices corresponding to points in `approx`.
 * @return cv::Point The tip if found, or `cv::Point(-1, -1)` if no valid tip exists.
 */
cv::Point find_tip(const std::vector<cv::Point> &approx, const std::vector<int> &hull) {
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

        int nextIndex = (indices[(i + 1) % 2] - 2 + static_cast<int>(approx.size()))
                        % static_cast<int>(approx.size());
        if (approx[j] == approx[nextIndex]) {
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
std::string get_arrow_direction(const cv::Point &tip, const cv::Rect &boundingBox) {
    cv::Point center = (boundingBox.tl() + boundingBox.br()) * 0.5;
    int dx = tip.x - center.x;
    int dy = tip.y - center.y;

    double angle = std::atan2(dy, dx) * 180.0 / CV_PI;
    if (angle >= -45 && angle <= 45)  return "Right";
    if (angle > 45 && angle < 135)   return "Down";
    if (angle <= -45 && angle > -135) return "Up";
    return "Left";
}

int main() {
    cv::VideoCapture cap(0);
    if (!cap.isOpened()) {
        std::cerr << "Error: Could not open the webcam!" << std::endl;
        return -1;
    }

    cv::namedWindow("Arrow Detection", cv::WINDOW_NORMAL | cv::WINDOW_GUI_NORMAL);
    cv::resizeWindow("Arrow Detection", 1280, 720);

    while (true) {
        cv::Mat frame;
        cap >> frame;
        if (frame.empty()) break;

        cv::Mat processed = preprocess(frame);
        std::vector<std::vector<cv::Point>> contours;
        std::vector<cv::Vec4i> hierarchy;

        cv::findContours(processed, contours, hierarchy, cv::RETR_EXTERNAL, cv::CHAIN_APPROX_NONE);

        for (const auto &cnt : contours) {
            double peri = cv::arcLength(cnt, true);
            std::vector<cv::Point> approx;
            cv::approxPolyDP(cnt, approx, 0.025 * peri, true);

            std::vector<int> hullIndices;
            cv::convexHull(approx, hullIndices, false);

            // If the hull size is between 4 and 6, we might have an arrow shape
            if (hullIndices.size() >= 4 && hullIndices.size() <= 6) {
                cv::Point arrow_tip = find_tip(approx, hullIndices);
                if (arrow_tip != cv::Point(-1, -1)) {
                    cv::Rect boundingBox = cv::boundingRect(cnt);
                    std::string direction = get_arrow_direction(arrow_tip, boundingBox);

                    cv::drawContours(frame, std::vector<std::vector<cv::Point>>{cnt},
                                     -1, cv::Scalar(0, 255, 0), 2);
                    cv::circle(frame, arrow_tip, 5, cv::Scalar(0, 0, 255), cv::FILLED);
                    cv::putText(frame, "Dir: " + direction,
                                boundingBox.br() + cv::Point(0, 20),
                                cv::FONT_HERSHEY_SIMPLEX, 0.5, cv::Scalar(255, 0, 0), 1);
                }
            }
        }

        cv::imshow("Arrow Detection", frame);
        if (cv::getWindowProperty("Arrow Detection", cv::WND_PROP_VISIBLE) < 1) {
            break;
        }
        if (cv::waitKey(30) >= 0) break;
    }

    cap.release();
    cv::destroyAllWindows();
    return 0;
}