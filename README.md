<p align="center">
  <a href="" rel="noopener">
 <img width=200px height=200px src="https://i.imgur.com/6wj0hh6.jpg" alt="Project logo"></a>
</p>

<h3 align="center">ZSH shell scripts to manage Tunnelblick VPN sessions from your SHELL</h3>

<div align="center">

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![GitHub Issues](https://img.shields.io/github/issues/gmkey/tunnelblick_cli_macos.svg)](https://github.com/gmkey/tunnelblick_cli_macos/issues)
[![GitHub Pull Requests](https://img.shields.io/github/gmkey/tunnelblick_cli_macos.svg)](https://github.com/gmkey/tunnelblick_cli_macos/pulls)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](/LICENSE)

</div>

---

<p align="center"> Few lines describing your project.
    <br> 
</p>

## 📝 Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Deployment](#deployment)
- [Usage](#usage)
- [Built Using](#built_using)
- [TODO](../TODO.md)
- [Contributing](../CONTRIBUTING.md)
- [Authors](#authors)
- [Acknowledgments](#acknowledgement)

## 🧐 About <a name = "about"></a>

The last few years I've been running tunnelblick to connect certain customer and business OpenVPN servers.
One of the more annoying things for me was the inability to control Tunnelblick sessions from the command line.
Especially when you - like me - are working on several projects in a day and the customer requests to perform a quick change on their environment. 

These shell scripts were created to be used with zsh to trigger the Applescript interface provided by tunnelblick. 

## 🏁 Getting Started <a name = "getting_started"></a>

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See [deployment](#deployment) for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them.
- [MacOS Ventura](https://www.apple.com/en/macos/ventura/)
- a terminal client like [iTerm2](https://iterm2.com)
- [Tunnelblick](https://tunnelblick.net) 


### Installing

#### the Easy route

```zsh
zsh <(curl -s https://raw.githubusercontent.com/gmkey/tunnelblick_cli_macos/master/install_vpnconnect_shell_integration.zsh)
```

A step by step series of examples that tell you how to get a development env running.

Say what the step will be

```
Give the example
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo.

## 🔧 Running the tests <a name = "tests"></a>

Explain how to run the automated tests for this system.

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## 🎈 Usage <a name="usage"></a>

Add notes about how to use the system.

## 🚀 Deployment <a name = "deployment"></a>

Add additional notes about how to deploy this on a live system.

## ⛏️ Built Using <a name = "built_using"></a>

- [Tunnelblick](https://www.tunnelblick.net/) - OpenVPN client for MacOS
- [zsh](https://www.zsh.org) - Zsh is a shell designed for interactive use, although it is also a powerful scripting language.


## ✍️ Authors <a name = "authors"></a>

- [@gmkey](https://github.com/gmkey) - Idea & Initial work

See also the list of [contributors](https://github.com/gmkey/tunnelblick_cli_macos/contributors) who participated in this project.

## 🎉 Acknowledgements <a name = "acknowledgement"></a>

- Hat tip to anyone whose code was used
- Inspiration
- References
