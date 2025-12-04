// mobile-app/src/constants/MONTHS.ts
export const MONTHS = [
  "JAN",
  "FEB",
  "MAR",
  "APR",
  "MAY",
  "JUN",
  "JUL",
  "AUG",
  "SEP",
  "OCT",
  "NOV",
  "DEC",
] as const;

export const toApiMonth = (monthIndex: number): number => monthIndex + 1;

export const fromApiMonth = (month: number): number => month - 1;