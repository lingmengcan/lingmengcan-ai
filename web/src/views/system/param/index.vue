<template>
  <div
    class="fixed z-30 inset-x-0 bottom-0 w-full pb-4 flex flex-col items-center rounded bg-white border border-black/10 shadow-[0_0_10px_rgba(0,0,0,0.10)] md:absolute md:left-0 md:top-[110%] md:bottom-auto md:w-[380px]"
  >
    <div class="w-full px-4 py-2 text-base font-bold border-b">参数设置</div>
    <div class="flex flex-col w-full gap-6 p-4">
      <div class="flex flex-col">
        <label class="mb-2 font-bold text-left text-neutral-700">系统提示</label>
        <textarea
          class="w-full px-4 py-3 bg-transparent border rounded border-neutral-200 text-neutral-900"
          placeholder="输入系统提示"
          rows="1"
          style="resize: none; max-height: 300px; overflow: hidden; height: 44px"
        ></textarea>
      </div>
    </div>
    <div class="w-full px-4 pb-4">
      <button
        type="button"
        class="w-full px-4 py-2 border rounded-lg shadow border-neutral-500 text-neutral-900 hover:bg-neutral-100 focus:outline-none"
      >
        确定
      </button>
    </div>
  </div>

  <div
    class="fixed top-0 right-0 min-h-screen max-h-screen z-50 bg-white flex w-[260px] flex-none flex-col pb-4 transition-all text-black lg:border lg:w-[400px] lg:absolute lg:min-h-[10rem] lg:max-h-[40rem] lg:top-12 lg:rounded-lg lg:shadow-[0_0_10px_rgba(0,0,0,0.10)]"
  >
    <div class="flex flex-col h-full gap-2">
      <div class="w-full h-16 border-b py-4 leading-8 indent-4 text-gy1 text-[1rem] font-semibold">
        提示词
      </div>
      <div class="px-4">
        <button
          class="flex w-full h-10 text-sidebar bg-white cursor-pointer select-none border-dashed items-center justify-center gap-3 rounded-md border border-[#DCDCDC]-1 text-gy1 transition-colors duration-200 hover:bg-gray-300/10"
        >
          <svg viewBox="0 0 18 18" width="18px" height="18px" style="display: block">
            <path
              d="M8.4375 9.5625H5.0625V8.4375H8.4375V5.0625H9.5625V8.4375H12.9375V9.5625H9.5625V12.9375H8.4375V9.5625Z"
              fill="#000"
              fill-opacity=".9"
            ></path>
            <path
              d="M9 16.875C13.3492 16.875 16.875 13.3492 16.875 9C16.875 4.65076 13.3492 1.125 9 1.125C4.65076 1.125 1.125 4.65076 1.125 9C1.125 13.3492 4.65076 16.875 9 16.875ZM9 15.75C5.27208 15.75 2.25 12.7279 2.25 9C2.25 5.27208 5.27208 2.25 9 2.25C12.7279 2.25 15.75 5.27208 15.75 9C15.75 12.7279 12.7279 15.75 9 15.75Z"
              fill="#000"
              fill-opacity=".9"
            ></path>
          </svg>
          新建提示词
        </button>
      </div>
      <div
        class="flex flex-1 flex-col gap-2 px-4 max-h-[calc(100vh-8rem)] lg:max-h-[32rem] scroll-bar flex-shrink-0 flex-grow-0"
        style="overflow: overlay"
      >
        <div
          class="h-[2.88rem] cursor-pointer rounded-[0.38rem] bg-gy1 border border-[#EBECF0] hover:bg-gy2 flex items-center px-4 gap-3 flex-shrink-0 flex-grow-0"
        >
          <svg viewBox="0 0 18 18" width="18px" height="18px" style="display: block">
            <path
              d="M9 11.8125C10.3964 11.8125 11.7248 12.1642 12.9375 12.802V14.0625L14.0625 14.0625V12.7782C14.0625 12.387 13.8614 12.0197 13.5163 11.8355C12.1379 11.0998 10.6116 10.6875 9 10.6875C7.38841 10.6875 5.86209 11.0998 4.48369 11.8355C4.13857 12.0197 3.9375 12.387 3.9375 12.7782V14.0625H5.0625V12.802C6.27518 12.1642 7.6036 11.8125 9 11.8125Z"
              fill="#000"
              fill-opacity=".9"
            ></path>
            <path
              d="M11.8125 6.75C11.8125 8.3033 10.5533 9.5625 9 9.5625C7.4467 9.5625 6.1875 8.3033 6.1875 6.75C6.1875 5.1967 7.4467 3.9375 9 3.9375C10.5533 3.9375 11.8125 5.1967 11.8125 6.75ZM10.6875 6.75C10.6875 5.81802 9.93198 5.0625 9 5.0625C8.06802 5.0625 7.3125 5.81802 7.3125 6.75C7.3125 7.68198 8.06802 8.4375 9 8.4375C9.93198 8.4375 10.6875 7.68198 10.6875 6.75Z"
              fill="#000"
              fill-opacity=".9"
            ></path>
            <path
              d="M2.8125 1.6875C2.19118 1.6875 1.6875 2.19118 1.6875 2.8125V15.1875C1.6875 15.8088 2.19118 16.3125 2.8125 16.3125H15.1875C15.8088 16.3125 16.3125 15.8088 16.3125 15.1875V2.8125C16.3125 2.19118 15.8088 1.6875 15.1875 1.6875H2.8125ZM15.1875 2.8125V15.1875H2.8125L2.8125 2.8125H15.1875Z"
              fill="#000"
              fill-opacity=".9"
            ></path>
          </svg>
          <div class="flex-1 pr-3 overflow-hidden break-all text-ellipsis whitespace-nowrap">
            abc
          </div>
          <div class="flex gap-3 cursor-pointer lg:hidden">
            <svg viewBox="0 0 18 18" width="18px" height="18px" style="display: block">
              <path
                d="M12.242 1.95406L15.8909 5.60287L16.6863 4.80737L13.0375 1.15857L12.242 1.95406Z"
                fill="rgba(0, 0, 0, 0.9)"
                fill-opacity=".9"
              ></path>
              <path
                d="M2.64606 15.5961L6.71065 14.7832L14.9204 6.57342L11.2716 2.92461L3.06185 11.1344L2.24893 15.199C2.2017 15.4352 2.40991 15.6434 2.64606 15.5961ZM11.2716 4.5156L13.3295 6.57342L6.15601 13.7469L3.58374 14.2613L4.0982 11.6891L11.2716 4.5156Z"
                fill="rgba(0, 0, 0, 0.9)"
                fill-opacity=".9"
              ></path></svg
            ><svg viewBox="0 0 14 14" width="18px" height="18px" style="display: block">
              <path d="M5.25 10.5V5.25H6.125V10.5H5.25Z" fill="rgba(0, 0, 0, 0.9)"></path>
              <path d="M7.875 5.25V10.5H8.75V5.25H7.875Z" fill="rgba(0, 0, 0, 0.9)"></path>
              <path
                d="M9.1875 2.625H12.25V3.5H11.375V12.25C11.375 12.7332 10.9832 13.125 10.5 13.125H3.5C3.01675 13.125 2.625 12.7332 2.625 12.25V3.5H1.75V2.625H4.8125L4.8125 1.575C4.8125 1.1884 5.1259 0.875 5.5125 0.875H8.4875C8.8741 0.875 9.1875 1.1884 9.1875 1.575V2.625ZM5.6875 2.625H8.3125L8.3125 1.75L5.6875 1.75V2.625ZM3.5 3.5V12.25H10.5V3.5H3.5Z"
                fill="rgba(0, 0, 0, 0.9)"
              ></path>
            </svg>
          </div>
        </div>
      </div>
    </div>
    <div
      class="absolute top-0 left-0 overflow-hidden flex items-center justify-center bg-[rgba(0,0,0,.1)] w-0 h-0"
    >
      <svg
        stroke="currentColor"
        fill="none"
        stroke-width="2"
        viewBox="0 0 24 24"
        stroke-linecap="round"
        stroke-linejoin="round"
        class="animate-spin"
        height="1em"
        width="1em"
        xmlns="http://www.w3.org/2000/svg"
      >
        <line x1="12" y1="2" x2="12" y2="6"></line>
        <line x1="12" y1="18" x2="12" y2="22"></line>
        <line x1="4.93" y1="4.93" x2="7.76" y2="7.76"></line>
        <line x1="16.24" y1="16.24" x2="19.07" y2="19.07"></line>
        <line x1="2" y1="12" x2="6" y2="12"></line>
        <line x1="18" y1="12" x2="22" y2="12"></line>
        <line x1="4.93" y1="19.07" x2="7.76" y2="16.24"></line>
        <line x1="16.24" y1="7.76" x2="19.07" y2="4.93"></line>
      </svg>
    </div>
  </div>
</template>
