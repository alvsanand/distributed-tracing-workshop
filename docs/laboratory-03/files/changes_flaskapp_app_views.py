######################################
# Add this after line "from app.serializers import ApplicationSerializer, LogSerializer"
######################################
from jaeger_client import Config
from flask_opentracing import FlaskTracing


def initialize_tracer():
    config = Config(
        config={'sampler': {'type': 'const', 'param': 1},
                'logging': True,
                'local_agent':
                {'reporting_host': app.config
                 ['JAEGER_AGENT_HOST'],
                 'reporting_port': app.config
                 ['JAEGER_AGENT_PORT']}},
        service_name="flask-app")

    return config.initialize_tracer()


jaeger_tracer = initialize_tracer()
tracing = FlaskTracing(jaeger_tracer, trace_all_requests=True, app=app)
######################################
