export interface Chat {
  dateTime: string;
  text: string;
  inversion?: boolean;
  error?: boolean;
  loading?: boolean;
  conversationOptions?: ConversationRequest | null;
  requestOptions: { prompt: string; options?: ConversationRequest | null };
}

export interface ConversationRequest {
  conversationId?: string;
  parentMessageId?: string;
}

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
export interface Dialog {
  dialogId?: string;
  dialogName: string;
  userName?: string;
  status: number;
  createdAt?: string;
  updatedAt?: string;
  isEdit?: boolean;
}

//消息
export interface Message {
  inversion: any;
  conversationOptions: any;
  error: any;
  loading: any;
  messageId?: string;
  dialogId: string;
  messageText: string;
  status: number;
  sender: string;
  createdAt?: string;
}
