import streamlit as st
from groq import Groq
from streamlit_js_eval import streamlit_js_eval

# Page config
st.set_page_config(page_title="StreamlitChatMessageHistory", page_icon="💬")
st.title("Chatbot")

# -------------------------
# Session State Variables
# -------------------------

if "setup_complete" not in st.session_state:
    st.session_state.setup_complete = False
if "user_message_count" not in st.session_state:
    st.session_state.user_message_count = 0
if "feedback_shown" not in st.session_state:
    st.session_state.feedback_shown = False
if "chat_complete" not in st.session_state:
    st.session_state.chat_complete = False
if "messages" not in st.session_state:
    st.session_state.messages = []

# -------------------------
# Helper Functions
# -------------------------

def complete_setup():
    st.session_state.setup_complete = True

def show_feedback():
    st.session_state.feedback_shown = True

# -------------------------
# Setup Stage
# -------------------------

if not st.session_state.setup_complete:

    st.subheader('Personal Information')

    if "name" not in st.session_state:
        st.session_state["name"] = ""
    if "experience" not in st.session_state:
        st.session_state["experience"] = ""
    if "skills" not in st.session_state:
        st.session_state["skills"] = ""

    st.session_state["name"] = st.text_input("Name", value=st.session_state["name"])
    st.session_state["experience"] = st.text_area("Experience", value=st.session_state["experience"])
    st.session_state["skills"] = st.text_area("Skills", value=st.session_state["skills"])

    st.subheader('Company and Position')

    if "level" not in st.session_state:
        st.session_state["level"] = "Junior"
    if "position" not in st.session_state:
        st.session_state["position"] = "Data Scientist"
    if "company" not in st.session_state:
        st.session_state["company"] = "Amazon"

    col1, col2 = st.columns(2)

    with col1:
        st.session_state["level"] = st.radio(
            "Choose level",
            ["Junior", "Mid-level", "Senior"],
            index=["Junior", "Mid-level", "Senior"].index(st.session_state["level"])
        )

    with col2:
        st.session_state["position"] = st.selectbox(
            "Choose a position",
            ("Data Scientist", "Data Engineer", "ML Engineer", "BI Analyst", "Financial Analyst"),
            index=("Data Scientist", "Data Engineer", "ML Engineer", "BI Analyst", "Financial Analyst").index(st.session_state["position"])
        )

    st.session_state["company"] = st.selectbox(
        "Select a Company",
        ("Amazon", "Meta", "Udemy", "365 Company", "Nestle", "LinkedIn", "Spotify"),
        index=("Amazon", "Meta", "Udemy", "365 Company", "Nestle", "LinkedIn", "Spotify").index(st.session_state["company"])
    )

    if st.button("Start Interview", on_click=complete_setup):
        st.write("Setup complete. Starting interview...")

# -------------------------
# Interview Phase
# -------------------------

if st.session_state.setup_complete and not st.session_state.feedback_shown and not st.session_state.chat_complete:

    st.info("Start by introducing yourself 👋")

    client = Groq(api_key=st.secrets["GROQ_API_KEY"])

    if not st.session_state.messages:
        st.session_state.messages = [{
            "role": "system",
            "content": (
                f"You are an HR executive interviewing {st.session_state['name']} "
                f"with experience {st.session_state['experience']} and skills {st.session_state['skills']}. "
                f"Interview them for {st.session_state['level']} "
                f"{st.session_state['position']} at {st.session_state['company']}."
            )
        }]

    for message in st.session_state.messages:
        if message["role"] != "system":
            with st.chat_message(message["role"]):
                st.markdown(message["content"])

    if st.session_state.user_message_count < 5:
        if prompt := st.chat_input("Your response", max_chars=1000):

            st.session_state.messages.append({"role": "user", "content": prompt})

            with st.chat_message("user"):
                st.markdown(prompt)

            if st.session_state.user_message_count < 4:
                with st.chat_message("assistant"):

                    stream = client.chat.completions.create(
                        model="llama-3.3-70b-versatile",
                        messages=[
                            {"role": m["role"], "content": m["content"]}
                            for m in st.session_state.messages
                        ],
                        stream=True,
                    )

                    response = st.write_stream(
                        (chunk.choices[0].delta.content or "")
                        for chunk in stream
                    )

                st.session_state.messages.append(
                    {"role": "assistant", "content": response}
                )

            st.session_state.user_message_count += 1

    if st.session_state.user_message_count >= 5:
        st.session_state.chat_complete = True

# -------------------------
# Feedback Button
# -------------------------

if st.session_state.chat_complete and not st.session_state.feedback_shown:
    if st.button("Get Feedback", on_click=show_feedback):
        st.write("Fetching feedback...")

# -------------------------
# Feedback Phase
# -------------------------

if st.session_state.feedback_shown:

    st.subheader("Feedback")

    conversation_history = "\n".join(
        [f"{msg['role']}: {msg['content']}" for msg in st.session_state.messages]
    )

    feedback_client = Groq(api_key=st.secrets["GROQ_API_KEY"])

    feedback_completion = feedback_client.chat.completions.create(
        model="llama-3.3-70b-versatile",
        messages=[
            {
                "role": "system",
                "content": """You are a tool that evaluates interview performance.
Before the feedback give a score from 1 to 10.
Format:
Overall Score: //
Feedback: //
Give only feedback."""
            },
            {
                "role": "user",
                "content": f"Evaluate this interview:\n{conversation_history}"
            }
        ]
    )

    st.write(feedback_completion.choices[0].message.content)

    if st.button("Restart Interview", type="primary"):
        streamlit_js_eval(js_expressions="parent.window.location.reload()")