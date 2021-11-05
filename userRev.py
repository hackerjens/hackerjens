#import packages
import csv as csv
import numpy as np

#read the csv file and make a list of variables
with open ('/home/pi/RSL/userReviews.csv') as data:
    userReviews_df = csv.reader(data)
    header = next(userReviews_df)
    df = list(userReviews_df)

#Split data and create a 'movies' dataframe
movies = df[:][0]
for i in range (0,1000):
    movies = [df [i][0].split(";") for i in range (0,1000)]

#Look for authors in the dataset in the range from 0-1000 (because it takes too long to search the entire dataset).
X = []
for i in range (0,1000):
    X += [movies[i][2]]

#Select favorite movie to make a recommendation list
Y = []
film = "the-hitmans-bodyguard"
for i in range(0,1000):
    if movies[i][0] == film:
        Y += [movies[i][2]]

#Create recommendation list based on favorite movie
Z = []
for j in range (0,len(Y)):
    recommendation = Y[j]
    for i in range (0,1000):
        if movies[i][2] == recommendation:
            Z += [movies[i][0]]
            
print(Z)

#Save recommendations (Z) as a CSV file
np.savetxt("recommendations.csv", Z, delimiter =",", fmt ='% s')