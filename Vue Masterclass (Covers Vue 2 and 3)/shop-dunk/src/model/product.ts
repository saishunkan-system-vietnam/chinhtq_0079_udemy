export interface Product {
  ctg?: number;
  data?: ProductDetail[];
}

export interface ProductDetail {
  id?: number;
  icon?: Thumb;
  image?: string;
  name?: string;
  currentPrice?: number;
  originalPrice?: number;
  sale?: string;
}

export interface Thumb {
  name?: string;
  image?: string;
}
