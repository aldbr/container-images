FROM registry.cern.ch/docker.io/mambaorg/micromamba

# Copying in ENTRYPOINT script and environment specification
COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yml entrypoint.sh /
RUN chmod 755 /entrypoint.sh

RUN micromamba install --yes --file /environment.yml --name=base && \
    micromamba clean --all --yes --force-pkgs-dirs

ARG MAMBA_DOCKERFILE_ACTIVATE=1

# In many clusters the container is ran as a random uid for security reasons.
# If we mark the conda directory as group 0 and give it group write permissions
# then we're still able to manage the environment from inside the container.
USER 0
RUN chown -R $MAMBA_USER:0 /opt/conda && chmod -R g=u /opt/conda
USER $MAMBA_USER

ENTRYPOINT [ "/entrypoint.sh" ]
