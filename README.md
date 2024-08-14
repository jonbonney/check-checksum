# check-checksum

A cross-platform CLI tool written in Go to compute a file's checksum and compare it against the expected value.

## Overview

The `check-checksum` tool calculates the checksum of a file using a specified hashing algorithm (e.g., SHA256, SHA1, MD5) and optionally compare the calculated checksum against an expected value. This is useful for verifying file integrity, especially when downloading files from the internet or transferring files between systems.

## Features

- Supports multiple hashing algorithms: SHA256 (default), SHA1, MD5, and SHA512.
- Can be run directly from the command line.
- Written in Go for portability and performance.
- Optionally compare the calculated checksum with an expected checksum provided by the user.

## Usage

```
Usage: check_checksum --filepath file_path [--expected checksum] [--algorithm algo]
       or: check_checksum -f file_path [-e checksum] [-a algo]
Options:
--filepath, -f  : Path to the file to check.
--expected, -e  : Expected checksum to compare against.
--algorithm, -a : Hashing algorithm to use (e.g., SHA256, SHA1, MD5). Default is SHA256.
--help, -h      : Display this help menu.
```

## Building the Go Source Code

To build the Go source code into a single portable binary that can be used on your system:

1. **Install Go**: Ensure that Go is installed on your system. You can download it from the official [Go website](https://golang.org/dl/).

2. **Clone the Repository**: If you haven't already, clone the repository to your local machine.

```
   git clone https://github.com/yourusername/check-checksum.git
   cd check-checksum
```

3. **Build the Binary**: Use the `go build` command to compile the Go source code into a single executable binary.

```
   go build -o check_checksum check_checksum.go
```

   This will create an executable file named `check_checksum` (or `check_checksum.exe` on Windows) in the current directory.

4. **Optional - Build for Multiple Platforms**: If you want to build the binary for a different platform or architecture, you can use the `GOOS` and `GOARCH` environment variables. For example, to build a Windows executable on a Unix system:

```
   GOOS=windows GOARCH=amd64 go build -o check_checksum.exe check_checksum.go
```

   Or for Linux:

```
   GOOS=linux GOARCH=amd64 go build -o check_checksum check_checksum.go
```

## Setting Up the PATH Variable

To use `check_checksum` as a CLI tool from any location on your system, you can add the directory containing the binary to your system's PATH environment variable.

### On Unix-based Systems (Linux, macOS)

1. **Move the Binary**: Move the `check_checksum` binary to a directory that's already in your PATH, or create a new directory for custom binaries.

```
   sudo mv check_checksum /usr/local/bin/
```

2. **Update PATH (if needed)**: If you moved the binary to a custom directory not in your PATH, add the directory to your PATH by editing your `.bashrc`, `.zshrc`, or `.profile` file.

```
   echo 'export PATH=$PATH:/path/to/your/custom/bin' >> ~/.bashrc
   source ~/.bashrc
```

### On Windows

1. **Move the Binary**: Move the `check_checksum.exe` binary to a directory that's already in your PATH, such as `C:\Windows\System32`, or create a new directory for custom binaries.

```
   move check_checksum.exe C:\Windows\System32\
```

2. **Update PATH (if needed)**: If you moved the binary to a custom directory not in your PATH, add the directory to your PATH:

   - Right-click on "This PC" or "Computer" on your desktop or in File Explorer.
   - Click "Properties."
   - Click "Advanced system settings."
   - Click "Environment Variables."
   - In the "System variables" section, find the `Path` variable, select it, and click "Edit."
   - Click "New" and add the path to the directory where you moved `check_checksum.exe`.
   - Click "OK" to close all the windows.

3. **Verify Installation**: Open a new command prompt or terminal window and type `check_checksum` to verify that the command is recognized.

## Contributing

Contributions to `check-checksum` are welcome! Please submit issues and pull requests through the [GitHub repository](https://github.com/jonbonney/check-checksum).

## License

This project is licensed under the MIT License. See the `LICENSE` file for details.
