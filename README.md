# Predicting-House-Price-Advanced-Regression-Techniques
Job is to predict the sales price for each house. For each Id in the test set.
#Start here if...
You have some experience with R or Python and machine learning basics. This is a perfect competition for data science students who have completed an online course in machine learning and are looking to expand their skill set before trying a featured competition.

# Data fields
Here's a brief version of what you'll find in the data description file.

* SalePrice - the property's sale price in dollars. This is the target variable that you're trying to predict.
* MSSubClass: The building class
* MSZoning: The general zoning classification
* LotFrontage: Linear feet of street connected to property
* LotArea: Lot size in square feet
* Street: Type of road access
* Alley: Type of alley access
* LotShape: General shape of property
* LandContour: Flatness of the property
* Utilities: Type of utilities available
* LotConfig: Lot configuration

Get Detail about all Variable Here
https://www.kaggle.com/c/house-prices-advanced-regression-techniques/data

# Competition Description
Ask a home buyer to describe their dream house, and they probably won't begin with the height of the basement ceiling or the proximity to an east-west railroad. But this playground competition's dataset proves that much more influences price negotiations than the number of bedrooms or a white-picket fence.

With 79 explanatory variables describing (almost) every aspect of residential homes in Ames, Iowa, this competition challenges you to predict the final price of each home.

# Practice Skills
Creative feature engineering 
Advanced regression techniques like random forest and gradient boosting

# Scatter Plot
![scatter_plot_area](https://user-images.githubusercontent.com/55012359/130115011-bfc21dfd-4b18-42c9-ae30-32acd7584dd8.png)
![scatter_plot_total](https://user-images.githubusercontent.com/55012359/130115047-09a63ff3-0e19-4214-a95e-c216ab5e7baf.png)

# Boruta Algorithm for Features Selection
Boruta iteratively removes features that are statistically less relevant than a random probe (artificial noise variables introduced by the Boruta algorithm). In each iteration, rejected variables are removed from consideration in the next iteration. It generally ends up with a good global optimization for feature selection which is why I like it.
# NonRejected Varible(Green), Rejected Varible(Yellow)

![Boruta_feature_sel](https://user-images.githubusercontent.com/55012359/130115860-c37787aa-af5a-495f-8f4f-6e582c2d551b.png)

# Variable Importance Graph(xgbTree)
![Variable Imp](https://user-images.githubusercontent.com/55012359/130116063-d8753b2c-6690-4aa6-a6ee-88d82a5248b8.png)

# ScatterPlot between Actual and Predicted SalePrice from Train Dataset
![actu_pre](https://user-images.githubusercontent.com/55012359/130116704-d4da0a58-9aa7-4198-b874-3b6b62395f41.png)

#Error Distribution (Hyperparameter tunning)

![error_hist](https://user-images.githubusercontent.com/55012359/130117187-9d80de60-1f79-4893-a3a3-24f163e97395.png)


# Acknowledgments
The Ames Housing dataset was compiled by Dean De Cock for use in data science education. It's an incredible alternative for data scientists looking for a modernized and expanded version of the often cited Boston Housing dataset. 
