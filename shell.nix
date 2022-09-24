with (import <nixpkgs> {});

mkShell {
  buildInputs = [
    google-cloud-sdk
    terraform
  ];
  shellHook = ''
    export OGRODJE_INFRA=`pwd`
    terraform -install-autocomplete &> /dev/null
    alias tf='terraform'
    gcloud config set project ogrodje
  '';
}
