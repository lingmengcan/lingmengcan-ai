//对话
export interface Conversation {
  conversationId?: string;
  conversationName: string;
  userName?: string;
  status: number;
  createdAt?: string;
  updatedAt?: string;
  isEdit?: boolean;
}

//消息
export interface Message {
  messageId?: string;
  conversationId: string;
  messageText: string;
  status: number;
  sender: string;
  createdAt?: string;
  loading?: boolean;
}
