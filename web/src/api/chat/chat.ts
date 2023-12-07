import { Dialog, Message } from '@/models/chat';
import { Method } from '@/utils/axios/types';
import http, { Result } from '@/utils/http';

// 获取对话列表
export const getDialogList = () => http.request<Result<Dialog[]>>('chat/dialog-list', Method.GET);

// 新增对话
export const addDialog = (data: Dialog) =>
  http.request<Result<Dialog>>('chat/add-dialog', Method.POST, data);

// 更新对话
export const editDialog = (data: Dialog) =>
  http.request<Result<Dialog>>('chat/edit-dialog', Method.POST, data);

// 改变状态为删除
export const changeDialogStatus = (data: Dialog) =>
  http.request<Result<Dialog>>('chat/change-dialog-status', Method.POST, data);

// 获取对话消息列表
export const getMessagesByDialogId = (data: String) =>
  http.request<Result<Message[]>>('chat/messages', Method.GET, data);

// 新增消息
export const addMessage = (data: Message) =>
  http.request<Result<Message>>('chat/add-message', Method.POST, data);

// 更新消息
export const editMessage = (data: Message) =>
  http.request<Result<Message>>('chat/edit-message', Method.POST, data);

// 改变状态为删除
export const changeMessageStatus = (data: Message) =>
  http.request<Result<Message>>('chat/change-message-status', Method.POST, data);

// 删除对话的所有消息
export const deleteMessagesByDialogId = (data: String) =>
  http.request<Result<String>>('chat/delete-messages-dialog', Method.POST, data);

// 对话
export const chat = (data: any) => http.request<any>('chat', Method.POST, data);

// 根据文件对话
export const chatfile = (data: any) => http.request<any>('chat/chatfile', Method.POST, data);
