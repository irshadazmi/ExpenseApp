export const parseIdParam = (
  id: string | string[] | undefined
): number | undefined => {
  const val = Array.isArray(id) ? id[0] : id;
  if (!val) return undefined;

  const num = Number(val);
  return Number.isNaN(num) ? undefined : num;
};
