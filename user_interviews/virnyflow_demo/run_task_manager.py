# Patch MongoDB client to disable SSL for local connections
import mongo_patch

import pathlib
from virny_flow.task_manager import TaskManager
from virny_flow.core.utils.common_helpers import create_exp_config_obj


if __name__ == "__main__":
    # Read an experimental config
    exp_config_yaml_path = pathlib.Path(__file__).parent.joinpath('configs').joinpath('exp_config.yaml')
    exp_config = create_exp_config_obj(exp_config_yaml_path=exp_config_yaml_path)

    task_manager = TaskManager(secrets_path=exp_config.common_args.secrets_path,
                               host='0.0.0.0',
                               port=8000,
                               exp_config=exp_config,
                               kafka_broker_address="kafka_broker:9092")
    task_manager.run()
