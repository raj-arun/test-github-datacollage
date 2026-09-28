SELECT
    pv.vendor_name                  AS supplier_name,
    ai.invoice_num,
    ai.invoice_date,
    ai.invoice_currency_code        AS currency,  --added a comment here for testing
    ai.invoice_amount,
    ai.amount_paid,
    (ai.invoice_amount - NVL(ai.amount_paid, 0)) AS amount_due,
    ai.payment_status_flag,
    ai.cancelled_date
FROM ap_invoices_all ai
JOIN poz_suppliers_v pv
    ON pv.vendor_id = ai.vendor_id
WHERE ai.invoice_date >= ADD_MONTHS(TRUNC(SYSDATE, 'MM'), -3) --last 3 months
ORDER BY pv.vendor_name, ai.invoice_date DESC;
