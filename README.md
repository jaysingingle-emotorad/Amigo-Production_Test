# EMotorad Amigo - PCB & Display Production Tester

A lightweight, zero-install Web Bluetooth testing application designed for the factory/production line to verify Amigo ESP32 display PCBs before assembly.

---

### Key Capabilities

1. **Automatic Device Discovery**: Scans and filters for boards advertising with prefix `Amigo-`.
2. **Full Security Authentication**:
   - Reads the 8-byte challenge from Auth characteristic (`6e400005-...`).
   - Computes SHA-256 hash using the 16-byte Secret + challenge + PIN `"0000"`.
   - Sends the response and verifies the `0x02` reply code.
3. **Display Power Verification**:
   - Sends the Display Power ON command `[14, 1, 1]` via Command characteristic (`6e400003-...`).
   - Listens on Telemetry notifications (`6e400002-...`) to confirm the Display ON flag (`Byte 1, bit 0x40`).
4. **Visual & Audio Operator Feedback**:
   - **PASS**: Giant Green Screen + High dual-tone audio chime.
   - **FAIL**: Giant Red Screen + Low buzzer chime with exact step error description.
   - **Spacebar Shortcut**: Operator can press **Spacebar** to trigger the test and advance to the next board without touching the mouse.
5. **Quality Assurance Shift Logging**:
   - Keeps track of all tested units, pass/fail rate, battery %, response times, and timestamps.
   - Single-click **"Export QA CSV Report"** to save production records into an Excel-compatible spreadsheet.

---

### How to Run

#### Option A: Running on a Smartphone (Android Phone - Recommended for Floor Testing)
Web Bluetooth requires a **Secure Context (HTTPS)** when accessed from a smartphone:

1. **Free Cloud Link (Easiest - 100% Free)**:
   - Deploy `index.html` to **GitHub Pages**, **Netlify Drop** (drag & drop at [app.netlify.com/drop](https://app.netlify.com/drop)), or **Vercel**.
   - You get a free link like `https://emotorad-tester.netlify.app`.
   - Operators can simply bookmark this URL or scan a printed QR code on their Android phones in **Google Chrome**. No app installation required!
2. **Via USB to Phone**:
   - Plug phone into PC with USB debugging enabled and run:
     `adb reverse tcp:8000 tcp:8000`
   - Open `http://localhost:8000` in Google Chrome on the phone.

#### Option B: 1-Click Launch on Windows Laptop
1. Double-click `start_tester.bat`.
2. Chrome / Edge will open automatically at `http://localhost:8000`.

---

### Testing Step-by-Step for Operators
1. Mount the PCB / Display on the jig and power on the board.
2. Press **Spacebar** (or click **"Scan & Verify Board"**).
3. In the browser Bluetooth popup, click the board (e.g. `Amigo-65717C`) and click **Pair/Connect**.
4. The screen will run the automated check (Auth $\to$ Power ON $\to$ Telemetry Verification).
5. When the screen flashes **GREEN (VERIFIED - PASS)**:
   - Check that the physical display is visibly lit.
   - Press **Spacebar** to disconnect and prepare for the next board!
