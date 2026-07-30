import * as crypto from "crypto";
import * as fs from "fs";
import * as path from "path";

const ALGORITHM = "aes-256-cbc";
const IV_LENGTH = 16;

function loadAesKey(): string {
  if (process.env.AES_KEY) {
    return process.env.AES_KEY;
  }

  const keysEnvPath = path.resolve(__dirname, "../../assets/keys.env");
  if (fs.existsSync(keysEnvPath)) {
    const content = fs.readFileSync(keysEnvPath, "utf8");
    const match = content.match(/^AES_KEY=(.+)$/m);
    if (match) {
      return match[1].trim();
    }
  }

  throw new Error("AES_KEY not found in environment or keys.env");
}

let cachedKey: Buffer | null = null;

function getKey(): Buffer {
  if (!cachedKey) {
    cachedKey = Buffer.from(loadAesKey(), "utf8");
  }
  return cachedKey;
}

export function encryptText(plainText: string): string {
  const iv = crypto.randomBytes(IV_LENGTH);
  const cipher = crypto.createCipheriv(ALGORITHM, getKey(), iv);
  const encrypted = Buffer.concat([
    cipher.update(plainText, "utf8"),
    cipher.final(),
  ]);
  const combined = Buffer.concat([iv, encrypted]);
  return combined.toString("base64");
}

export function decryptText(encryptedBase64: string): string {
  const combined = Buffer.from(encryptedBase64, "base64");
  const iv = combined.subarray(0, IV_LENGTH);
  const encrypted = combined.subarray(IV_LENGTH);
  const decipher = crypto.createDecipheriv(ALGORITHM, getKey(), iv);
  const decrypted = Buffer.concat([
    decipher.update(encrypted),
    decipher.final(),
  ]);
  return decrypted.toString("utf8");
}
