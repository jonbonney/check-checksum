package main

import (
	"crypto/md5"
	"crypto/sha1"
	"crypto/sha256"
	"crypto/sha512"
	"encoding/hex"
	"flag"
	"fmt"
	"hash"
	"io"
	"os"
)

func main() {
	// Define command line flags
	filepath := flag.String("filepath", "", "Path to the file to check.")
	expected := flag.String("expected", "", "Expected checksum to compare against.")
	algorithm := flag.String("algorithm", "SHA256", "Hashing algorithm to use (e.g., SHA256, SHA1, MD5). Default is SHA256.")
	help := flag.Bool("help", false, "Display this help menu.")

	// Define short flags
	flag.StringVar(filepath, "f", "", "Path to the file to check.")
	flag.StringVar(expected, "e", "", "Expected checksum to compare against.")
	flag.StringVar(algorithm, "a", "SHA256", "Hashing algorithm to use (e.g., SHA256, SHA1, MD5). Default is SHA256.")
	flag.BoolVar(help, "h", false, "Display this help menu.")

	// Parse command line flags
	flag.Parse()

	// Show help and exit if --help or -h is provided
	if *help || *filepath == "" {
		fmt.Println("Usage: check_checksum --filepath file_path [--expected checksum] [--algorithm algo]")
		fmt.Println("       or: check_checksum -f file_path [-e checksum] [-a algo]")
		fmt.Println("Options:")
		fmt.Println("--filepath, -f  : Path to the file to check.")
		fmt.Println("--expected, -e  : Expected checksum to compare against.")
		fmt.Println("--algorithm, -a : Hashing algorithm to use (e.g., SHA256, SHA1, MD5). Default is SHA256.")
		fmt.Println("--help, -h      : Display this help menu.")
		os.Exit(0)
	}

	// Open the file
	file, err := os.Open(*filepath)
	if err != nil {
		fmt.Printf("Error opening file: %v\n", err)
		os.Exit(1)
	}
	defer file.Close()

	// Select the hashing algorithm
	var hasher hash.Hash
	switch *algorithm {
	case "SHA256":
		hasher = sha256.New()
	case "SHA1":
		hasher = sha1.New()
	case "MD5":
		hasher = md5.New()
	case "SHA512":
		hasher = sha512.New()
	default:
		fmt.Printf("Unsupported algorithm: %s\n", *algorithm)
		os.Exit(1)
	}

	// Calculate the checksum
	if _, err := io.Copy(hasher, file); err != nil {
		fmt.Printf("Error calculating checksum: %v\n", err)
		os.Exit(1)
	}
	checksum := hex.EncodeToString(hasher.Sum(nil))

	// Print the checksum
	fmt.Printf("Calculated %s checksum: %s\n", *algorithm, checksum)

	// If an expected checksum was provided, compare it
	if *expected != "" {
		if checksum == *expected {
			fmt.Println("Checksum matches the expected value.")
		} else {
			fmt.Println("Checksum does NOT match the expected value.")
			os.Exit(1)
		}
	}
}
