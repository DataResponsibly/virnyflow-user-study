# VirnyFlow User Study

## VirnyFlow Architecture

<p align="center">
    <img src="./virnyflow_architecture.png" alt="System Design" width="75%">
</p>


## How to Start the VirnyFlow Task

VirnyFlow provides separate Docker Compose configurations depending on your machine's processor architecture.

- **For Macs with Apple Silicon (ARM processors):** use `docker-compose-arm.yaml`
- **For Intel/AMD machines:** use `docker-compose-amd.yaml`

### Start the Task

```bash
# For ARM (Apple Silicon)
docker-compose -f docker-compose-arm.yaml up

# For AMD/Intel
docker-compose -f docker-compose-amd.yaml up
```

### Stop the Task and Remove Volumes

```bash
# For ARM (Apple Silicon)
docker-compose -f docker-compose-arm.yaml down --volumes

# For AMD/Intel
docker-compose -f docker-compose-amd.yaml down --volumes
```
