import { Conversation, Message } from '@/models/chat';
import { Method } from '@/utils/axios/types';
import http, { Result } from '@/utils/http';

// 获取对话列表
export const getConversationList = () =>
  http.request<Result<Conversation[]>>('chat/conversation/list', Method.GET);

// 新增对话
export const addConversation = (data: Conversation) =>
  http.request<Result<Conversation>>('chat/conversation/add', Method.POST, data);

// 更新对话
export const editConversation = (data: Conversation) =>
  http.request<Result<Conversation>>('chat/conversation/edit', Method.POST, data);

// 改变状态为删除
export const changeConversationStatus = (data: Conversation) =>
  http.request<Result<Conversation>>('chat/change-conversation-status', Method.POST, data);

// 获取对话消息列表
export const getMessagesByConversationId = (data: String) =>
  http.request<Result<Message[]>>('chat/messages', Method.GET, data);

// 新增消息
export const addMessage = (data: Message) =>
  http.request<Result<Message>>('chat/message/add', Method.POST, data);

// 更新消息
export const editMessage = (data: Message) =>
  http.request<Result<Message>>('chat/message/edit', Method.POST, data);

// 改变状态为删除
export const changeMessageStatus = (data: Message) =>
  http.request<Result<Message>>('chat/change-message-status', Method.POST, data);

// 清空对话的所有消息
export const deleteMessagesByConversationId = (data: String) =>
  http.request<Result<String>>('chat/clear-conversation-messages', Method.POST, data);

// 对话
export const chat = (data: any) => http.request<any>('chat', Method.POST, data);

// 根据文件对话
export const chatfile = (data: any) => http.request<any>('chat/chatfile', Method.POST, data);
