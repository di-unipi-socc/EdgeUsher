from problog.extern import problog_export, problog_export_nondet, problog_export_raw

@problog_export('+list', '-list')
def update(l):
    """Computes the sum of two numbers."""
    print(l)
    for i in l:
        print(type(i))
    return l



