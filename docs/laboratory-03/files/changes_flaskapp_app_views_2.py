######################################
# Add this after line "from flask_opentracing import FlaskTracing"
######################################
from opentracing_instrumentation.client_hooks import install_all_patches
######################################

######################################
# Add this after line "tracing = FlaskTracing(jaeger_tracer, trace_all_requests=True, app=app)"
######################################
install_all_patches()
######################################
