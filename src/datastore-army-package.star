helpers = import_module('github.com/kurtosis-tech/datastore-army-package/src/helpers.star')

DATASTORE_IMAGE = "kurtosistech/example-datastore-server"
DATASTORE_PORT_ID = "grpc"
DATASTORE_PORT_NUMBER = 1323
DATASTORE_TRANSPORT_PROTOCOL = "TCP"
SERVICE_ID_PREFIX = "datastore-"


def add_datastore_service(unique_service_id):
    print("Adding service " + unique_service_id)

    service_config = struct(
        image = DATASTORE_IMAGE,
        ports = {
            DATASTORE_PORT_ID: PortSpec(number = DATASTORE_PORT_NUMBER, transport_protocol = DATASTORE_TRANSPORT_PROTOCOL)
        }
    )
    add_service(service_id = unique_service_id, config = service_config)
    return DATASTORE_PORT_ID


def add_multiple_datastore_services(num_datastores):
    service_id_to_port_id = {}
    for index in range(num_datastores):
        service_id = SERVICE_ID_PREFIX + str(index)
        service_id_to_port_id[service_id] = add_datastore_service(service_id)
    return service_id_to_port_id