# fastscore.input: gbm_input
# fastscore.output: gbm_output

import cPickle
import numpy as np
import pandas as pd

from sklearn.ensemble import GradientBoostingRegressor
from sklearn.pipeline import Pipeline

import imp

def begin():
    FeatureTransformer = imp.load_source("FeatureTransformer",
                                         "score_auto_gbm/FeatureTransformer.py")
    global gbmFit
    with open("score_auto_gbm/gbmFit.pkl", "rb") as pickle_file:
        gbmFit = cPickle.load(pickle_file)

def action(datum):
    score = list(gbmFit.predict(pd.DataFrame([datum])))[0]
    yield score
