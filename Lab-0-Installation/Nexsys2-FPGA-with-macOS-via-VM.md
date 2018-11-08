# Using the Digilent Nexsys 2 FPGA board with macOS via VM
## IDE: ISE Design Suite (Web Pack)

*A complete guide!*

**BACKGROUND:**  With a bit of work, macOS users are able to run the Windows-only Xilinx ISE Design Suite software on their Apple computers. This will allow streamlined completion of all labs that make use of the Nexys 2 board. This procedure may also work well for the Nexys 4 board that requires Vivado Design Suite, however no guarantees are made until this combination is evaluated in the future (expect updates to this guide).

METHOD: By using the Free and Open-Source (FOSS) program VirtualBox provided by Oracle, combined with some specific dependency requirements, hypervisor interfacing, and port-forwarding settings.

**REQUIREMENTS:**
- macOS (Mojave 10.14.1 tested)
- Windows 7 Ultimate (Windows 10 *not* tested)
- VirtualBox (5.2 tested)
  - Guest Additions hypervisor interface
- Xilinx ISE Design Suite (14.7-1015-1)
- Xilinx Adept 2 System (2.19.2)

**PROCEDURE:**
1. Download and install VirtualBox 5.2 from https://www.virtualbox.org/
2. Within VirtualBox, create a new Windows 7 Professional session
    1. [VM recommended init settings]
    2. Install Windows 7 on the initialized VM
    3. Install the *Guest Additions* hypervisor interface
        1. [install guide]
    4. Finalize the VM recommended settings:
        1. [final settings]
        2. Connect board, power on, wait 30 seconds for macOS to finish recognising
            1. create filter
            2. turn off board, unplug
3. Start the Windows 7 VM, check that all updates are installed
4. Download and Install *ISE Design Suite - 14.7  Full Product Installation: Full DVD, Single File Download Image* (7.78 GB)
    1. Download link: https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/design-tools/v2012_4---14_7.html
    2. [pic of DL]
    3. If needed, install 7-Zip to extract the TAR/GZ
        1. Download link: https://www.7-zip.org/
        2. [pic	]


Extract the entire folder to your desktop
[pic of extracted folder]
Start install by selecting [[[]]]
[pic]
During the install, when asked which edition to install, select WebPACK
Have Cable Drivers selected when asked
[pic]
Licensing is the same as Professor Ackland's / any other guide. Select the free ISE license, and follow the guidance to generate and apply the node license.
Restart the VM (Windows start menu --> Restart)
Now, install Adept 2 System (2.19.2) on the VM
Download link: https://reference.digilentinc.com/reference/software/adept/start?redirect=1#software_downloads
[pics]
Restart the VM again (Windows start menu --> Restart)
Connect the board to the computer with the USB cable.
Ensure the FPGA board power switch is turned off (switch is near the VGA connector, off-position is inboard)
Ensure the Power Select jumper is set to USB
Connect USB cable on both ends
Slide the power switch on the board on, observe the board powers-up.
Observe the installation popup in the windows system tray, as the board is recognized inside the Windows VM. Allow the installation to finish.
Launch the Device Manager, check installation was successful
[pic]
Launch Adept 2
[pic]
Confirm that the board is recognized in Adept 2
[pic]
Celebrate!
Switch to the testing tab of Adept 2
Launch the board test, RAM test, and Flash test
[pic]
[when running ISE, make sure to right-click and start as Adminitrator. Additionaly, project can only be saved to the C:\\ directory and not much else due to VM-Unix filesystem permissions irregularities]
