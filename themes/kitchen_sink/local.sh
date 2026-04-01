local thisdir=$(dirname $BASH_SOURCE)
. "${thisdir}/helpers.sh"

local sep="$(fgc 240)│$NOC"

local user_host=''
local current_dir="$(fgc 75)\\w$NOC"
local pc=''

# Root detection (Solaris-compatible)
local user_id
user_id=$(id | cut -f1 -d' ' | sed -e 's/(.*$//' | cut -f2 -d'=')

if [[ "$user_id" -eq 0 ]]; then
  user_host="$(fgc 196)\\u$(fgc 11)@$(fgc 27)\\H$NOC"
  pc="$(fgc 196)➤$NOC"
else
  user_host="$(fgc 46)\\u$(fgc 11)@$(fgc 27)\\H$NOC"
  pc="➤$NOC"
fi

# Line 1: identity and environment
# Ruby segment (conditional)
local ruby_seg="\$(ruby_out=\$(ps1_ruby); [[ -n \"\$ruby_out\" ]] && echo \" ${sep} $(fgc 009)‹\${ruby_out}›$NOC\")"
# Node segment (conditional)
local node_seg="\$(node_out=\$(__ks_ps1_node); [[ -n \"\$node_out\" ]] && echo \" ${sep} $(fgc 148)⬡\${node_out}$NOC\")"
# Venv segment (conditional)
local venv_seg="\$(venv_out=\$(__ks_ps1_venv); [[ -n \"\$venv_out\" ]] && echo \" ${sep} $(fgc 214)🐍\${venv_out}$NOC\")"

local line1="${user_host} ${sep} ${current_dir}${ruby_seg}${node_seg}${venv_seg}"

# Line 2: git, status, and time
# Git segment (conditional)
local git_seg="\$(branch=\$(ps1_git_branch); [[ -n \"\$branch\" ]] && echo \"$(fgc 208)\$(ps1_git_status)$(fgc 191)\${branch}$NOC $(fgc 245)\$(ps1_sha)$NOC\")"
# Exit code segment (conditional)
local exit_seg="\$(exit_out=\$(__ks_ps1_exit_code); [[ -n \"\$exit_out\" ]] && echo \" ${sep} $(fgc 196)✘\${exit_out}$NOC\")"
# Jobs segment (conditional)
local jobs_seg="\$(jobs_out=\$(__ks_ps1_jobs); [[ -n \"\$jobs_out\" ]] && echo \" ${sep} $(fgc 74)⚙\${jobs_out}$NOC\")"
# Timestamp (always)
local time_seg="$(fgc 242)\\t$NOC"

# Build line 2: if git is present, show git then conditionals then time
# If no git, just show conditionals and time
local line2="\$(branch=\$(ps1_git_branch); if [[ -n \"\$branch\" ]]; then echo \"$(fgc 208)\$(ps1_git_status)$(fgc 191)\${branch}$NOC $(fgc 245)\$(ps1_sha)$NOC${exit_seg}${jobs_seg} ${sep} ${time_seg}\"; else exit_part=\$(__ks_ps1_exit_code); jobs_part=\$(__ks_ps1_jobs); parts=''; [[ -n \"\$exit_part\" ]] && parts=\"$(fgc 196)✘\${exit_part}$NOC\"; [[ -n \"\$jobs_part\" ]] && { [[ -n \"\$parts\" ]] && parts=\"\${parts} ${sep} \"; parts=\"\${parts}$(fgc 74)⚙\${jobs_part}$NOC\"; }; [[ -n \"\$parts\" ]] && parts=\"\${parts} ${sep} \"; echo \"\${parts}${time_seg}\"; fi)"

PS1="${line1}
${line2}
${pc} "$NOC
