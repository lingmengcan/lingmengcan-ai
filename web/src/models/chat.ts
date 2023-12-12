export interface ConversationResponse {
  conversationId: string;
  detail: {
    choices: { finish_reason: string; index: number; logprobs: any; text: string }[];
    created: number;
    id: string;
    model: string;
    object: string;
    usage: { completion_tokens: number; prompt_tokens: number; total_tokens: number };
  };
  id: string;
  parentMessageId: string;
  role: string;
  text: string;
}

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
