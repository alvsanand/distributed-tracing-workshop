######################################
# Add this after line "                app.config['MONGO_PORT'])[app.config['MONGO_DB_NAME']]"
######################################


def tracing_method_decorator(decorated_function):
    from flask import request

    def trace(*args, **kwargs):
        try:
            from app.views import jaeger_tracer, tracing

            current_span = tracing.get_span(request)

            cls = args[0]

            with jaeger_tracer.start_span('mongodb', child_of=current_span) \
                    as child_span:
                child_span.set_tag('mongodb.collection', cls.COLLECTION.name)
                child_span.set_tag('mongodb.operation',
                                   decorated_function.__name__)
        except Exception as e:
            print("Error while tracing method: {}".format(str(e)))
        finally:
            return decorated_function(*args, **kwargs)
    return trace
######################################

######################################
# Add this after lines "    @classmethod"
######################################
    @tracing_method_decorator
######################################
