<h1 align="center">💽 GitBK</h1>

<div align="center">

![](https://img.shields.io/badge/PRs-welcome-green.svg)
[![GitHub](https://img.shields.io/github/license/jparadadev/gitbk)](https://github.com/jparadadev/gitbk/blob/main/LICENSE)
  
</div>

![](https://raw.githubusercontent.com/jparadadev/gitbk/assets/assets/logo.png)

This Bash script automates the process of backing up or updating your GitHub repositories. It fetches a list of repository names from a specified `.bk` repository and either clones them (if they're not already present on your local machine) or updates them (if they already exist).

## Features

- **Automatic Backup:** Clones or updates repositories based on a list fetched from GitHub.
- **Easy to Use:** Simply specify your GitHub username and the output directory.
- **Flexible:** Uses a central repository to manage the list of repositories you want to back up.

## Prerequisites

Before you start using this script, make sure you have `git` and `curl` installed on your system. These tools are essential for cloning repositories and fetching the list of repositories from GitHub.

## Usage

1. **Clone this Script**

First, clone this script to your local machine using the following command:

   ```bash
   git clone https://github.com/YOUR_USERNAME/YOUR_REPOSITORY.git
   ```

2. **Make the Script Executable**

Change the script's permissions to make it executable:

   ```bash
   chmod +x backup_github_repos.sh
   ```

3. **Execute the Script**

Run the script with your GitHub username and optionally specify an output directory where the repositories should be cloned or updated:

   ```bash
   ./backup_github_repos.sh --user <YourGitHubUsername> [-o <OutputDirectory>]
   ```

Replace <YourGitHubUsername> with your actual GitHub username and <OutputDirectory> with the path where you'd like the repositories to be saved. If you do not specify an output directory, the script will use the current directory by default.

## Customization

To customize the list of repositories you want to back up or update, you need to:

1. Create a .bk repository in your GitHub account.
2. Add a repos.txt file to the main branch with one repository name per line.

The script will fetch this file and use it to determine which repositories to clone or update.

## Contributing

Contributions are what make the open-source community such an amazing place to learn, inspire, and create. Any contributions you make are greatly appreciated.

1. Fork the Project
2. Create your Feature Branch (git checkout -b feature/AmazingFeature)
3. Commit your Changes (git commit -m 'Add some AmazingFeature')
4. Push to the Branch (git push origin feature/AmazingFeature)
5. Open a Pull Request
