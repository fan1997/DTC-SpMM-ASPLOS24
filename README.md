### Prepare your environment.

```shell
# RTX 4090 (prefer) or 3090 with CUDA 12.1 installed.
export PATH=/usr/local/cuda-12.1/bin:$PATH
export CUDA_HOME="/usr/local/cuda-12.1/"
export LD_LIBRARY_PATH=/usr/local/cuda-12.1/lib64:$LD_LIBRARY_PATH

# Create and activate virtual env
conda create -n DTCSpMM python=3.9
conda activate DTCSpMM

# install PyTorch (must)
conda install pytorch pytorch-cuda=12.1 -c pytorch -c nvidia

# install cmake, numpy and scipy (must)
conda install cmake
pip install numpy
pip install scipy

# install cugraph (Optional for TCA-reordering)
pip install cugraph-cu12 --extra-index-url=https://pypi.nvidia.com

# install cupy (Optional for TCA-reordering)
pip install cupy-cuda12x

# install cudf (Optional for TCA-reordering)
pip install --extra-index-url=https://pypi.nvidia.com cudf-cu12

# install minhashcuda (Optional for TCA-reordering)
cd DTCSpMM/reordering && cmake -DCMAKE_BUILD_TYPE=Release . && make && python setup.py install
```

### Clone DTC-SpMM

```shell
git clone --recursive 
cd DTC-SpMM-ASPLOS24 && source init_dtc.sh
```

### Prepare Sputnik (dependency)

```shell
cd DTC-SpMM-ASPLOS/third_party/
source ./build_sputnik.sh
```

### Build DTC-SpMM

```shell
cd ../DTC-SpMM && source build.sh
```

### Download datasets

```shell
git lfs clone --include-all https://github.com/fan1997/dtc_datasets.git
cd dtc_datasets
tar -zxvf reordered_matrices.tar.gz
tar -zxvf origin_matrices.tar.gz
```

### Run tests

``` SHELL
# Run DTCSpMM
cd scripts/DTCSpMM 
# modify the dataset path in run_DTCSpMM.py to your own path.
source run_DTCSpMM.sh

# Run cuSPARSE
cd scripts/cuSPARSE 
# modify the dataset path in run_DTCSpMM.py to your own path.
source run_cuSPARSESpMM.sh
```

### Use TCA-reordering

```shell
cd TCA-reordering
# Run an example to reorder reddit dataset
python TCA_reorder.py --dataset reddit --thres 16
```

