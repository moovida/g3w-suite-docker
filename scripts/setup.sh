#! /bin/bash
# Main script for the build of Docker images g3wsuite/g3w-suite:v3.7.x
# ====================================================================

if [ -z "$(ls -A /code)" ]; then
   echo "Cloning g3w-admin branch ${G3W_SUITE_BRANCH:-v.3.7.x} ..."
   git clone https://github.com/g3w-suite/g3w-admin.git --single-branch --branch ${G3W_SUITE_BRANCH:-v.3.7.x} /code && \
   cd /code
fi

cp /requirements_rl.txt .

# Override settings
# -----------------
pip3 install -r requirements_rl.txt
pip3 install -r requirements_huey.txt

# Frontend module
# ---------------
git submodule add -f https://github.com/g3w-suite/g3w-admin-frontend.git  g3w-admin/frontend

# Install requirements for the following modules:
# Caching, File manager, Qplotly, Openrouteservice
# ------------------------------------------------
pip3 install -r /code/g3w-admin/caching/requirements.txt && \
pip3 install -r /code/g3w-admin/filemanager/requirements.txt && \
pip3 install -r /code/g3w-admin/qplotly/requirements.txt && \
pip3 install -r /code/g3w-admin/openrouteservice/requirements.txt

