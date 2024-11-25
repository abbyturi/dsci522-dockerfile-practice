# Extend the Jupyter minimal-notebook image
FROM quay.io/jupyter/minimal-notebook:afe30f0c9ad8

# Copy the conda lock file into the image
COPY conda-linux-64.lock /tmp/conda-linux-64.lock

# Install dependencies listed in the conda lock file
RUN mamba update --quiet --file /tmp/conda-linux-64.lock \
    && mamba clean --all -y -f \
    && fix-permissions "${CONDA_DIR}" \
    && fix-permissions "/home/${NB_USER}"

# Expose Jupyter notebook port
EXPOSE 8888

# Default command to run the notebook
CMD ["start-notebook.sh"]

