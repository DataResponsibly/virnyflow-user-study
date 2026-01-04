# VirnyFlow User Study


## Repository Structure

This repository contains materials and code used in the IRB-approved user study evaluating **VirnyFlow**, a system for context-sensitive and human-centric ML pipeline development.

### `materials/` Folder

The `materials/` folder contains all artifacts provided to participants during the user study:

- **`Task1.ipynb`**  
  Google Colab notebook used in *Task 1*, where participants measure and interpret model performance using VirnyFlow. This task establishes the problem context and introduces multi-objective trade-offs.

- **`VirnyFlow_Study_Enrollment_Form.pdf`**  
  Enrollment and consent form used prior to the study to collect basic demographic information. Personally identifying information is stored separately and not included in the research data.

- **`VirnyFlow_User_Experience_and_Usability_Form.pdf`**  
  Post-study survey assessing overall system usability, perceived usefulness, and self-reported workflow efficiency when using VirnyFlow.

- **`VirnyFlow_User_Study_Form.pdf`**  
  Main task form used during the study to collect participants’ responses for all study tasks, including performance evaluation, configuration, and visualization-based reasoning.

- **`VirnyFlow_User_Study_Tutorial_Notes.pdf`**  
  Introductory tutorial provided during the pre-study phase. The document explains the motivation for context-aware ML development, key evaluation metrics, and the principles of multi-objective optimization used in VirnyFlow.

### `virnyflow_task/` Folder

The `virnyflow_task/` folder contains code and configuration files required to run the VirnyFlow task locally.

All materials are provided for transparency and reproducibility and reflect the procedures described in the approved IRB protocol.


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


## VirnyFlow Execution Demo

Watch a video demonstration of VirnyFlow in action: [VirnyFlow Execution Demo](https://www.youtube.com/watch?v=odb_FSpjoQE).
