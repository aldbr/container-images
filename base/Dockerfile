FROM mambaorg/micromamba:latest

# Copying in ENTRYPOINT script and environment specification
COPY --chown=$MAMBA_USER:$MAMBA_USER environment.yml dirac_dependencies.yml /tmp/
COPY --chown=$MAMBA_USER:$MAMBA_USER entrypoint.sh /
RUN chmod 755 /entrypoint.sh

RUN micromamba install --freeze-installed --yes --file /tmp/environment.yml  --name=base && \
    micromamba install --freeze-installed --yes --file /tmp/dirac_dependencies.yml --name=base && \
    micromamba clean --all --yes --force-pkgs-dirs && \
    rm -rf /tmp/environment.yml /tmp/dirac_dependencies.yml

ARG MAMBA_DOCKERFILE_ACTIVATE=1

# In many clusters the container is ran as a random uid for security reasons.
# If we mark the conda directory as group 0 and give it group write permissions
# then we're still able to manage the environment from inside the container.
USER 0
RUN chown -R $MAMBA_USER:0 /opt/conda && chmod -R g=u /opt/conda
USER $MAMBA_USER

ENTRYPOINT [ "/entrypoint.sh" ]
