@tool
@abstract
extends CmdlineParser;
class_name Cmd;


## Disabled the few cases where threading is used.
const DISABLED_THREADING := "--disable-threading";
