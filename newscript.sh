#!/usr/bin/env bash

# This script creates a new script!

scriptfile="new_script"

echo "#!/usr/bin/env" > "${scriptfile}"
printf "\n" >> "${scriptfile}"
echo "# Author: Jimmy O'Donnell <jodonnellbio@gmail.com>" >> "${scriptfile}"
printf "\n" >> "${scriptfile}"


printf '%80s\n' | tr ' ' \# >> "${scriptfile}"

printf '%80s\n' | tr ' ' % >> "${scriptfile}"

printf '%80s\n' | tr ' ' - >> "${scriptfile}"

# printf '#%.0s' {1..80}; printf '\n' >> "${scriptfile}"
# printf '%%.0s' {1..80}; printf '\n' >> "${scriptfile}"
