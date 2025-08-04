<div align="center">

# asdf-terramaid [![Build](https://github.com/arnaullamas/asdf-terramaid/actions/workflows/build.yml/badge.svg)](https://github.com/arnaullamas/asdf-terramaid/actions/workflows/build.yml) [![Lint](https://github.com/arnaullamas/asdf-terramaid/actions/workflows/lint.yml/badge.svg)](https://github.com/arnaullamas/asdf-terramaid/actions/workflows/lint.yml)


[terramaid](https://github.com/rosesecurity/terramaid) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`: generic POSIX utilities.

# Install

Plugin:

```shell
asdf plugin add terramaid https://github.com/arnaullamas/asdf-terramaid.git
```

terramaid:

```shell
# Show all installable versions
asdf list-all terramaid

# Install specific version
asdf install terramaid latest

# Set a version globally (on your ~/.tool-versions file)
asdf global terramaid latest

# Now terramaid commands are available
terramaid version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/arnaullamas/asdf-terramaid/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Arnau Llamas](https://github.com/arnaullamas/)

# Thanks

[Zufar Dhiyaulhaq](https://zufardhiyaulhaq) for his [trivy](https://github.com/zufardhiyaulhaq/asdf-trivy) plugin that
served as a huge inspiration for this plugin.
