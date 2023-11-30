import { Method } from '@/utils/axios/types';
import http from '@/utils/http';

// 改变状态
export const chat = (data: any) => http.request<any>('chat', Method.POST, data);

// 改变状态
export const chatfile = (data: any) => http.request<any>('chat/file', Method.POST, data);
