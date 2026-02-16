{ pkgs, inputs, ... }:

let
  llmAgents = inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system};
in {
  environment.systemPackages = [
    llmAgents.claude-code
    llmAgents.claudebox
  ];
}
