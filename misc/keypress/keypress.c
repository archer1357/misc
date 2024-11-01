#define WINVER 0x0500
#include <windows.h>

void sendRawMouse(HWND hWnd) {
    RAWINPUT raw;
    raw.header.dwType = RIM_TYPEMOUSE;
    raw.data.mouse.usButtonFlags=RI_MOUSE_LEFT_BUTTON_DOWN;
    raw.data.mouse.usFlags=MOUSE_MOVE_RELATIVE;
    raw.data.mouse.usButtonFlags=0;
    raw.data.mouse.lLastX=0;
    raw.data.mouse.lLastY=0;
    raw.data.mouse.ulExtraInformation=0;

    // SendMessage(hWnd, WM_INPUT, 0, (LPARAM)raw);
}

void mouseRightDown() {
    // INPUT input;
    // input.type=INPUT_MOUSE;
    // input.mi.dx=0;
    // input.mi.dy=0;
    // input.mi.mouseData=0;
    // input.mi.dwFlags=MOUSEEVENTF_RIGHTDOWN;

    // input.mi.dwExtraInfo=0;
    // input.mi.time=0;
    // SendInput(1,&input,sizeof(INPUT));
    keybd_event(VK_LBUTTON,
  0x01,
  0,
0
);
}
LRESULT CALLBACK WndProc(HWND hWnd,UINT message,WPARAM wParam,LPARAM lParam) {
    if(message==WM_DESTROY ||
       (message==WM_CHAR && wParam==VK_ESCAPE)) {
        PostQuitMessage(0);
        return 0;
    }

    if(message == WM_HOTKEY) {
        HWND h = FindWindow(NULL, "Ace of Spades");

        if(h) {
            DWORD vk= (DWORD)HIWORD(lParam);

            if(vk==VK_F10) {
                // PostMessage(h, WM_LBUTTONDOWN, MK_LBUTTON, MAKELPARAM(0, 0));
                // PostMessage(h, WM_MOUSEACTIVATE, h, 0);
                // PostMessage(h, WM_LBUTTONDOWN, 0, 0);
                // PostMessage(h, WM_LBUTTONUP, 0, 0);
                // PostMessage(h, WM_RBUTTONDOWN , MK_RBUTTON, 0);
                // PostMessage(h, WM_RBUTTONDOWN, MK_RBUTTON, MAKELPARAM(0, 0));
                // DWORD t=GetProcessIdOfThread(h);
                // DWORD t2=GetCurrentThreadId();
                // BOOL r=AttachThreadInput(t,t2,TRUE);
                // if(!r){printf("Err1\n");}
                // SetFocus(h);

                // PostMessage(h, WM_KEYDOWN, 'Q', 0);
                mouseRightDown();
                // Sleep(1000);
                // ShowWindow(h, SW_HIDE);
                // ShowWindow(h, SW_MINIMIZE);

                // Sleep(500);
                PostMessage(h, WM_KEYDOWN, 'W', 0);


            } else if(vk==VK_F9) {
                PostMessage(h, WM_SYSKEYDOWN , VK_SHIFT, 0);
                PostMessage(h, WM_KEYDOWN, 'W', 0);

            }

            LPARAM lParam = MAKELPARAM(0, 0);
            SendMessage(h, WM_LBUTTONDOWN, MK_LBUTTON, lParam);
        }

    }

    return DefWindowProc(hWnd,message,wParam,lParam);
}

int main(int argc, char* argv[]) {
    HINSTANCE hInstance=GetModuleHandle(0);

    WNDCLASS wc = { };
    wc.lpfnWndProc   = WndProc;
    wc.hInstance     = hInstance;
    wc.lpszClassName = "keypress";
    wc.hbrBackground = (HBRUSH)(COLOR_GRAYTEXT);
    wc.style = CS_HREDRAW | CS_VREDRAW;
    wc.hCursor = LoadCursor(NULL,IDC_ARROW);

    RegisterClass(&wc);

    HWND hWnd = CreateWindow(wc.lpszClassName,wc.lpszClassName,
                             WS_OVERLAPPEDWINDOW|WS_VISIBLE,
                             CW_USEDEFAULT,CW_USEDEFAULT,120,120,
                             NULL,NULL,hInstance,NULL);

    RegisterHotKey(hWnd,0,0,VK_F10);
    RegisterHotKey(hWnd,0,0,VK_F9);

    MSG msg = { };

    while(GetMessage(&msg, NULL, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }

    return 0;
}
