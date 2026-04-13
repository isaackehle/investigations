. ./helpers.sh
. ./setup_continue.sh
. ./setup_opencode.sh
. ./setup_crush.sh
. ./setup_claude.sh

setup_all() {
    setup_continue
    setup_opencode
    setup_crush
    setup_claude
    print_status "All tool configurations applied"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    setup_all
fi
