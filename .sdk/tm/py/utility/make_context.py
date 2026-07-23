# BluefinDecryptx SDK utility: make_context

from core.context import BluefinDecryptxContext


def make_context_util(ctxmap, basectx):
    return BluefinDecryptxContext(ctxmap, basectx)
