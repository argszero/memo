https://studiolab.sagemaker.aws/users/argszero

创建conda环境：

1. conda create --name pytorch-forecasting
2. conda activate pytorch-forecasting
3. conda install pytorch-forecasting pytorch>=1.7 -c pytorch -c conda-forge
4. conda env export | grep -v "^prefix: " >pytorch-forecasting.yml