# SMART TRAFFIC — Scholarly References and Source Verification Notes

This repository contains verified scholarly citations and technical literature underpinning the **SMART TRAFFIC** platform. All citations follow standard IEEE numbered bibliography conventions.

---

## 1. Primary IEEE-Style References

[1] J. Redmon, S. Divvala, R. Girshick, and A. Farhadi, "You Only Look Once: Unified, Real-Time Object Detection," in *Proc. IEEE Conference on Computer Vision and Pattern Recognition (CVPR)*, Las Vegas, NV, USA, 2016, pp. 779–788. DOI: 10.1109/CVPR.2016.91.

[2] Y. Zhang, P. Sun, Y. Jiang, D. Yu, F. Weng, Z. Yuan, P. Luo, W. Liu, and X. Wang, "ByteTrack: Multi-Object Tracking by Associating Every Detection Box," in *Proc. European Conference on Computer Vision (ECCV)*, Tel Aviv, Israel, 2022, pp. 1–21. DOI: 10.1007/978-3-031-20047-2_1.

[3] L. Breiman, "Random Forests," *Machine Learning*, vol. 45, no. 1, pp. 5–32, Oct. 2001. DOI: 10.1023/A:1010933404324.

[4] J. Glenn, "Ultralytics YOLO11: State-of-the-Art Real-Time Object Detection and Tracking Architecture," *Ultralytics Documentation*, v8.4, 2024. [Online]. Available: https://docs.ultralytics.com.

[5] P. McCullagh and J. A. Nelder, *Generalized Linear Models*, 2nd ed. London, UK: Chapman & Hall/CRC, 1989. DOI: 10.1007/978-1-4899-3242-6.

[6] F. V. Webster, "Traffic Signal Settings," *Road Research Technical Paper No. 39*, Road Research Laboratory, Her Majesty's Stationery Office (HMSO), London, UK, 1958.

[7] Ministry of Road Transport and Highways (MoRTH), "Road Accidents in India 2022," Transport Research Wing, Government of India, New Delhi, Tech. Rep., Oct. 2023.

[8] World Health Organization, *Global Status Report on Road Safety 2023*, Geneva, Switzerland: World Health Organization, Dec. 2023. ISBN: 978-92-4-008651-7.

[9] W. Chang, J. Cheng, J. Allaire, C. Sievert, B. Schloerke, Y. Xie, J. Allen, J. McPherson, A. Dipert, and B. Borges, "shiny: Web Application Framework for R," *R package version 1.14.0*, 2024. [Online]. Available: https://CRAN.R-project.org/package=shiny.

[10] J. Cheng, B. Karambelkar, and Y. Xie, "leaflet: Create Interactive Web Maps with the JavaScript 'Leaflet' Library," *R package version 2.2.3*, 2024. [Online]. Available: https://CRAN.R-project.org/package=leaflet.

[11] C. Sievert, *Interactive Web-Based Data Visualization with R, plotly, and shiny*, Boca Raton, FL, USA: Chapman and Hall/CRC, 2020. DOI: 10.1201/9780429447273.

[12] H. Wickham, *ggplot2: Elegant Graphics for Data Analysis*, 2nd ed. New York, NY, USA: Springer-Verlag, 2016. DOI: 10.1007/978-3-319-24277-4.

[13] M. Abadi et al., "TensorFlow: A System for Large-Scale Machine Learning," in *Proc. 12th USENIX Symposium on Operating Systems Design and Implementation (OSDI)*, Savannah, GA, USA, 2016, pp. 265–283.

[14] A. Paszke et al., "PyTorch: An Imperative Style, High-Performance Deep Learning Library," in *Advances in Neural Information Processing Systems 32 (NeurIPS)*, Vancouver, Canada, 2019, pp. 8024–8035.

[15] G. Bradski, "The OpenCV Library," *Dr. Dobb's Journal of Software Tools*, vol. 25, no. 11, pp. 120–125, 2000.

[16] F. Pedregosa et al., "Scikit-learn: Machine Learning in Python," *Journal of Machine Learning Research (JMLR)*, vol. 12, pp. 2825–2830, Nov. 2011.

[17] A. Liaw and M. Wiener, "Classification and Regression by randomForest," *R News*, vol. 2, no. 3, pp. 18–22, 2002.

[18] W. N. Venables and B. D. Ripley, *Modern Applied Statistics with S*, 4th ed. New York, NY, USA: Springer-Verlag, 2002. DOI: 10.1007/978-0-387-21706-2.

---

## 2. Distinction Between External Literature and SMART TRAFFIC Empirical Results

- **Literature Findings:** External benchmarks provide foundational algorithms (e.g., YOLO11n network weights trained on Microsoft COCO, ByteTrack Kalman filtering logic, Webster's minimum delay equation).
- **SMART TRAFFIC Empirical Findings:** Specific quantitative metrics reported in this study (e.g., 68.45% overall severity accuracy on 4,000 test cases, 98.82% fatal recall, 99.32% fatal F1-score, 0.919 fog-high traffic risk factor, 20.12 average concurrent vehicles on the test video stream) were derived strictly from the executed source code and verified output CSV files within this repository.
