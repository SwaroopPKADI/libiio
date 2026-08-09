# Compiling libiio

## Requirements
- **cmake** installed on your system
- **Visual Studio 2022** installed with the C++ pack  
  *(Community Edition is okay too if you face issues with the Pro version download)*
> **Note:** The next step of installing dependencies can be skipped if you have the deps.zip extracted to the path `c/deps`.
- **Dependencies** as required by [Building libiio in Visual Studio (Analog Devices Wiki)](https://wiki.analog.com/resources/tools-software/linux-software/libiio)
> **Note:** The dependencies are not included in the repository, so you will need to install them manually.
- **libserialport** dependency:
    1. Clone the repository:
        ```sh
        git clone https://github.com/sigrokproject/libserialport.git
        ```
    2. Open `libserialport.sln` in Visual Studio and build in **Release** mode.

> **Note:** You need to install dependencies in a `c/deps` folder as expected by the build tools.

---

## Easy Build Steps

1. Run the `build_libiio.bat` file located in the root of the repository. This will:
    - Clean and Build the Libiio DLLs and executables for the C programs which will go to the build folder.
2. Go to the [my_build](http://_vscodecontentref_/0) folder.
3. Run `builds.bat` to collect all the required exes, dlls into a folder named with timestamp.
4. Copy the folder contents to:
    ```
    C:\Program Files (x86)\libiio\lib\libiio
    ```

---

## Testing

- After a successful build (or if you already have the DLLs and executables installed at the above path), run:
    ```
    start_iio_env.bat
    ```
    to start testing the command-line tools.

- For custom executables, set the environment path to:
    ```
    C:\Program Files (x86)\libiio\lib\libiio
    ```
    and test as needed.

---

## Troubleshooting

If you are confused:
- Ensure you have all required DLLs and executables installed at the specified path.
- Update the env path to include:
    ```
    C:\Program Files (x86)\libiio\lib\libiio
    ```
- Run the executables from the command line to see any error messages.
---