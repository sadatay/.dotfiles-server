bash_escape() ( printf '\\033[%dm' $1; );
RESET=$(bash_escape 0);
RESET_BOLD=$(bash_escape 21);
RESET_DIM=$(bash_escape 22);
#BOLD=$(bash_escape 1);
BOLD=''
DIM=$(bash_escape 2);
RED=$(bash_escape 31);
GREEN=$(bash_escape 32);
YELLOW=$(bash_escape 33);
BLUE=$(bash_escape 34);
MAGENTA=$(bash_escape 35);
DEFAULT=$(bash_escape 39);

SUCCESS="${GREEN}${DIM}[SUCCESS]${RESET}";
FAILURE="${RED}${DIM}[FAILURE]${RESET}";
FAILURE_MARK="[ ${RED}✘${DEFAULT} ]";
SUCCESS_MARK="[ ${GREEN}✔${DEFAULT} ]";
NOOP_MARK="[ ${BLUE}○${DEFAULT} ]";

# Logging methods
put_command() ( echo; printf "${BOLD}${GREEN}[COMMAND]${DEFAULT} *** $1 ***\n";);
put_warning() ( printf "${BOLD}${YELLOW}[WARNING]${DEFAULT} $1\n");
put_note() ( printf "${BOLD}${BLUE}[NOTE]${RESET} $1\n");
put_bullet_1() ( printf "       ${BOLD}${BLUE}↳  [ ${RESET}$(dim "$1")${BOLD}${BLUE} ]${RESET}\n" );
put_bullet_2() ( printf "          ${BOLD}${BLUE}↳  [ ${RESET}$(dim "$1")${BOLD}${BLUE} ]${RESET}\n" );
put_prompt() ( echo -e -n "${BOLD}${MAGENTA}[PROMPT]${DEFAULT} $1 : ${RESET}" );
put_error() ( printf "${BOLD}${RED}[ERROR]${DEFAULT} $1\n" );
put_success() ( printf "${DIM}${GREEN}[SUCCESS]${RESET} $1 ${SUCCESS_MARK}\n" );
put_failure() ( printf "${DIM}${RED}[FAILURE]${RESET} $1 ${FAILURE_MARK}\n" );
highlight() ( printf "${YELLOW}$1${DEFAULT}" );
success() ( printf "${BOLD}${GREEN}$1${DEFAULT}" );
failure() ( printf "${BOLD}${RED}$1${DEFAULT}" );
dim() ( printf "${DIM}$1${RESET_DIM}" );
bold() ( printf "${BOLD}$1${RESET_BOLD}" );
