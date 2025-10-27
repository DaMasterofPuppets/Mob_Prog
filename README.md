# Empress Reads

# Email Backend (Supabase Edge Function)
- we will be using [resend](resend.com) which will be our email API.

## prerequisites
- resend and supabase account
- supabase CLI https://github.com/supabase/cli/releases (amd64.tar)
 
## steps
- Look for the .zip file of the supabase CLI and extract it.
- Add that folder to the PATH
- (optional)  to check if CLI is working, go to powershell: supabase --version
- create another folder
- open it in terminal and then type: supabase login
- Link the folder: supabase link --project-ref tzyrhyxaecvbvlebxrab
- inside that folder: supabase functions new send-booking-email
- open that folder, open index.ts, then replace it with our currently working email backend:

```
import { serve } from "https://deno.land/std@0.177.0/http/server.ts";
import { Resend } from "https://esm.sh/resend@3.2.0";

const resend = new Resend(Deno.env.get("RESEND_API_KEY")!);

function json(data: unknown, status = 200): Response {
  return new Response(JSON.stringify(data), {
    status,
    headers: {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "*",
      "Access-Control-Allow-Headers":
        "Content-Type, Authorization, apikey, X-Client-Info, x-client-info, x-client-version, Accept",
      "Access-Control-Allow-Methods": "POST, OPTIONS",
    },
  });
}

serve(async (req: Request) => {
  if (req.method === "OPTIONS") return json({ ok: true });
  if (req.method !== "POST") return json({ error: "Method not allowed" }, 405);

  try {
    const { time, date, message, email, package: selectedPackage } = await req.json();
    console.log("PAYLOAD_FROM_CLIENT", { time, date, email, selectedPackage, message });

    if (!time) return json({ error: "Time is required" }, 400);
    if (!selectedPackage) return json({ error: "Package is required" }, 400);

    const body = [
      "Good Day, Empress!",
      "",
      "New Booking schedule:",
      "",
      `Email From: ${email ?? "Unknown"}`,
      `Date: ${date ?? ""}`,
      `Time: ${time ?? ""}`,
      `Package: ${selectedPackage ?? "Not specified"}`,
      message ? `Additional Message: ${message}` : undefined,
      "",
      "(Please send them an email ASAP!)",
    ].filter(Boolean).join("\n");

    const result = await resend.emails.send({
      from: "Bookings <onboarding@resend.dev>",
      to: ["c202301060@iacademy.edu.ph"],
      subject: "Empress Reads - New Schedule Booking",
      text: body,
    });

    console.log("RESEND_RESULT", result);
    return json({ success: true, result });
  } catch (err) {
    console.error("RESEND_ERROR", err);
    return json({ error: (err as Error).message ?? "Unknown error" }, 500);
  }
});
```

- For resend account connection: supabase secrets set RESEND_API_KEY=(API KEY)
  
- Deploy the function: supabase functions deploy send-booking-email

- Also config.toml
```
[functions]
verify_jwt = false
```
