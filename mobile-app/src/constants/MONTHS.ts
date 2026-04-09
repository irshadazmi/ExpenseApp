// mobile-app/src/constants/MONTHS.ts
export const MONTHS = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
] as const;

export const toApiMonth = (monthIndex: number): number => monthIndex + 1;

export const fromApiMonth = (month: number): number => month - 1;