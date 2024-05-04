#!/bin/sh
set -xe

# Node.js repo
curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION} | bash - &&\
apt-get install -y nodejs

# yarn repo
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | tee /etc/apt/trusted.gpg.d/yarn.gpg
echo "deb [signed-by=/etc/apt/trusted.gpg.d/yarn.gpg] https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt-get update >/dev/null
apt-get -y --no-install-recommends install yarn
apt-get clean
rm -rf /var/lib/apt/lists/*


