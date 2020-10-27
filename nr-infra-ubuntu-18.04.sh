# Add the New Relic Infrastructure Agent gpg key \
curl -s https://download.newrelic.com/infrastructure_agent/gpg/newrelic-infra.gpg | sudo apt-key add - && \

\

# Create a configuration file and add your license key \
config=$(cat <<-END
license_key: <LICENSE-KEY>
verbose: 0
log_file: /var/log/newrelic-infra.log
custom_attributes:
  environment: production
  service: Azure Databricks
  team: A-Team
END
) \
echo "$config" | sudo tee -a /etc/newrelic-infra.yml \

\

# Create the agent’s apt repository \
printf "deb [arch=amd64] https://download.newrelic.com/infrastructure_agent/linux/apt bionic main" | sudo tee -a /etc/apt/sources.list.d/newrelic-infra.list && \

\

# Update your apt cache \
sudo apt-get update && \

\

# Run the installation script \
sudo apt-get install newrelic-infra -y
