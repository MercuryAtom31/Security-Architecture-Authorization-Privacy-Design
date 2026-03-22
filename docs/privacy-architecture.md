# Privacy & Internet Tracking

## Objective

Understand how users are tracked online and design a system that protects user privacy while maintaining business functionality.

---

## Tracking Methods

### Cookies

Cookies store user data in the browser and are commonly used for session management and tracking.

Risk:

* Can track users across multiple websites
* Often used for advertising and profiling

---

### Browser Fingerprinting

Fingerprinting collects information such as:

* Browser type
* Operating system
* Screen resolution
* Installed fonts

This creates a unique identifier without storing data on the device.

Risk:

* Difficult to detect or block
* Enables persistent tracking without consent

---

### IP Tracking

IP addresses reveal:

* User location
* Network provider

Risk:

* Can be combined with other data to identify users

---

## Identity Correlation

When combined, these tracking methods can uniquely identify users.

Example:
Cookies + fingerprinting + IP address = strong user profiling

---

## Privacy-Friendly Architecture

### Anonymization Layer

Removes personally identifiable information and replaces it with anonymous identifiers.

Example:

* Email → Random user ID

---

### Tokenization

Sensitive data is replaced with tokens.

Example:

* Credit card number → Token

This ensures that even if data is exposed, it cannot be directly used.

---

### Minimal Data Collection

Only necessary data is collected.

Example:

* No unnecessary tracking of user behavior
* No long-term storage of IP addresses

---

### Consent Management

Users are informed and can control what data is collected.

Example:

* Opt-in for cookies
* Ability to withdraw consent

---

### Data Separation

Sensitive identity data is stored separately from activity data.

This prevents full user profiles from being easily reconstructed.

---

## Compliance Considerations

### GDPR

Requires:

* Data minimization
* Explicit user consent
* Right to erasure

---

### CCPA

Requires:

* Transparency about data collection
* Ability to opt-out of data sharing

---

## Why This Design Works

* Reduces tracking capabilities
* Limits exposure of sensitive data
* Aligns with legal frameworks
* Improves user trust

---

## Limitation

Complete anonymity is difficult to achieve due to advanced tracking techniques such as fingerprinting and data correlation.
