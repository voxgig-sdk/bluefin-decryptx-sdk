# BluefinDecryptx SDK feature factory

from feature.base_feature import BluefinDecryptxBaseFeature
from feature.test_feature import BluefinDecryptxTestFeature


def _make_feature(name):
    features = {
        "base": lambda: BluefinDecryptxBaseFeature(),
        "test": lambda: BluefinDecryptxTestFeature(),
    }
    factory = features.get(name)
    if factory is not None:
        return factory()
    return features["base"]()
